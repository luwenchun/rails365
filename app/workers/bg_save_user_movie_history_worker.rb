class BgSaveUserMovieHistoryWorker
  include Sidekiq::Worker

  def perform
    User.bg_save_movie_history
    User.bg_send_aliyun_avatar
    Rails.cache.delete "new_users"
  end
end
