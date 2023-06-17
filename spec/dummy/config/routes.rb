Rails.application.routes.draw do
  mount Assistant::Engine => "/assistant"
end
