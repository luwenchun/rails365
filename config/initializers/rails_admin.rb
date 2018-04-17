RailsAdmin.config do |config|
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  config.navigation_static_links = {
    'sidekiq web' => '/sidekiq',
    'pghero' => '/pghero',
    'searchjoy' => '/searchjoy'
  }

  config.model Group do
    edit do
      field :name
      field :image, :carrierwave
      field :desc
      field :weight
    end
  end

  config.model Playlist do
    edit do
      field :name
      field :image, :carrierwave
      field :desc
      field :weight
      field :is_paid
      field :is_original
      field :is_finished
    end
  end

  config.model Serial do
    edit do
      field :name
      field :weight
    end
  end

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
