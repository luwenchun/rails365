class Comment < ApplicationRecord
  include IdentityCache

  belongs_to :article, optional: true
  belongs_to :movie, optional: true
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  cache_belongs_to :commentable

  # include PublicActivity::Model
  # tracked owner: ->(controller, model) { controller && controller.current_user }
  include PublicActivity::Common

  validates :body, :user, presence: true

  acts_as_notifiable :users,
    # Notification targets as :targets is a necessary option
    # Set to notify to author and users commented to the article, except comment owner self
    targets: ->(comment, key) {
      ([comment.commentable.user] - [comment.user]).uniq
    },
    # Path to move when the notification is opened by the target user
    # This is an optional configuration since activity_notification uses polymorphic_path as default
    notifiable_path: :movie_notifiable_path,
    notifier: :user,
    group: :commentable,
    tracked: { only: [:create] }

  def movie_notifiable_path
    movie_path(movie)
  end

  after_create :publish_create

  private

  def publish_create
    unless Rails.env.test?
      if self.commentable_type == "Article"
        ActionCable.server.broadcast \
          'web_channel', { title: '获得评论',
                           content: "学员 <strong>#{self.user.hello_name}</strong> 评论了文章 #{self.commentable.title}"
        }.to_json
      end

      if self.commentable_type == "Movie"
        ActionCable.server.broadcast \
          'web_channel', { title: '获得评论',
                           content: "学员 <strong>#{self.user.hello_name}</strong> 评论了视频 #{self.commentable.title}"
        }.to_json

        # SendSystemHistory.send_system_history("学员 #{self.user.hello_name}", "评论了", self.commentable.title)
      end
    end
  end
end
