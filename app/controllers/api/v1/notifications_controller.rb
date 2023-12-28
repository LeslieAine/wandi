class Api::V1::NotificationsController < ApplicationController
    def index
        user = User.find(params[:user_id])
        notifications = user.notifications.map{ |n| NotificationSerializer.new(n)}
        
        render json: notifications.to_json
    end

    def update
        notification = Notification.find(params[:id])
        notification.update(seen: true)

        render json: notification.to_json
    end

    def mark_all_as_seen
        user = User.find(params[:user_id])
        notifications = user.notifications.map{ |n| n.update(seen: true) }

        render json: notifications.to_json
    end
end