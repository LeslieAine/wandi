class Api::V1::AboutsController < ApplicationController
    # before_action :authenticate_user!
    before_action :set_about, only: [:show, :edit, :update]

    def show
        user = User.find(params[:user_id])
        
        if user.about.blank?
          # If user.about is empty, create a new About object with default values
          @about = About.new(topics: 'No topics listed yet', 
          interests: 'No interests added yet', languages: 'No languages added yet', links: 'No links to their work yet')
        else
          @about = user.about
        end
      
        render json: @about, status: :ok
      end
      
  
    def edit
      # Render the form to edit the user's about
    end
  
    def update
      # Update the user's about with the submitted data
      if @about.update(about_params)
        render json: @about, status: :ok
      else
        render json: @about.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_about
      @about = current_user.about || current_user.build_about
    end
  
    def about_params
    #   params.require(:about).permit(:topics, :languages, :interests, links: [])
    # Permit the 'links' attribute for partial updates
        allowed_params = params.require(:about).permit(:topics, :languages, :interests, links: [])
        
        # Merge the existing links with the new links
        existing_links = @about.links || []
        allowed_params[:links] = existing_links.concat(allowed_params[:links])

        allowed_params
    end
  end
  