class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show]

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.valid? && @ticket.save

      #
      # Here we need to check: did that ticket say to deactivate a scooter?
      # If so, deactivate it before rendering.
      #

      if @ticket.deactivate_scooter?
        @ticket.scooter.deactivate!
      end
      render json: @ticket
    else
      render plain: "Bad Request", status: :bad_request
    end
  end

  def show
    render json: @ticket
  end

private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:scooter_id, :notes, :deactivate_scooter, :opened_by)
  end
end
