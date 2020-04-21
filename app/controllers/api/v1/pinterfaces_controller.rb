module Api
  module V1
    class PinterfacesController < ApplicationController
      

      def index
        render json:{status:"SUCCESS",message:"INDEX SUCCESS LOADING"}
      end

      def token

        render json:{status:"SUCCESS",message:"INDEX SUCCESS LOADING"}
      end

      def player

        token = params[:token]
        

        render json:{status:"SUCCESS",message:"PLAYER SUCCESS LOADING "+token}
      end

     

    end
  end
end
