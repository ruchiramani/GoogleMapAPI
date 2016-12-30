class ContactsController < ApplicationController
before_action :get_contacts, only: [:index]

  def index
    @contacts = Contact.paginate(:page => params[:page], :per_page => 5)
  end

   def get_contacts
     if Contact.count < 1
      key = # Define key here
     response = HTTParty.get('https://demo-api.m76.co/contacts',headers: {"Accept" => 'application/vnd.m76.v2+json', "Authorization" => key} )
      response["data"].each do |c|
        url = "https://demo-api.m76.co/contacts/#{c['id']}/accounts"
        account = HTTParty.get(url , headers: {"Accept" => 'application/vnd.m76.v2+json', "Authorization" => key } )
        Contact.find_or_create_by(name: c["attributes"]["first_name"], email: c["attributes"]["email_primary"], accounts: account.count)
        end
      end
    end


end
