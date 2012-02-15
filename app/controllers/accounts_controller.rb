class AccountsController < ApplicationController
  load_and_authorize_resource
  # GET /accounts
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  def show
    @account = Account.find(params[:id])
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /accounts
  def create
    @account = Account.new(params[:account])
    if @account.save
      redirect_to @account, notice: 'Account was successfully created.'
    else
      render action: "new" 
    end
  end

  # PUT /accounts/1
  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(params[:account])
      redirect_to @account, notice: 'Account was successfully updated.' 
    else
      render action: "edit" 
    end
  end

  # DELETE /accounts/1
  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    redirect_to accounts_url 
  end

  def voucher
    @unit_choices_text = get_unit_choices_text
  end

  def travel
    @unit_choices_text = get_unit_choices_text
  end

  def festihvalen
    @unit_choices_text = get_unit_choices_text
  end


  def print_voucher
    usages = {}
    @account = Account.find(params[:voucher][:unit]) if params[:voucher][:unit]

    params[:voucher].keys.each do |key|
      if key =~ /amount\d+|description\d+/ then
        usages[key] = params[:voucher][key]
      end
    end
    params[:usages] = usages
    @sum = 0.0

    for i in 1..((params[:usages].size / 2)  )
      @sum += params[:usages]["amount#{i}"].sub(/,/, '.').to_d
    end
    render layout:false
  end

  def print_travel
    usages = {}
    @account = Account.find(params[:voucher][:unit])

    params[:voucher].keys.each do |key|
      if key =~ /date\d+|route\d+|means\d+|amount\d+/ then
        usages[key] = params[:voucher][key]
      end
    end
    params[:carriers] = usages
    @sum = 0.0
    for i in 1..(params[:carriers].size / 4)
      @sum += params[:carriers]["amount#{i}"].sub(/,/, '.').to_d
    end

    render layout:false

  end

  def print_festihvalen
    usages = {}
    @account = Account.find(params[:voucher][:unit]) if params[:voucher][:unit]

    params[:voucher].keys.each do |key|
      if key =~ /amount\d+|description\d+/ then
        usages[key] = params[:voucher][key]
      end
    end
    params[:usages] = usages
    @sum = 0.0

    for i in 1..((params[:usages].size / 2)  )
      @sum += params[:usages]["amount#{i}"].sub(/,/, '.').to_d
    end
    render layout:false
  end


  private

  def get_unit_choices_text
    unit_choices = []

    # Accounts NOT tied to specific sections (section_id=nil)
    generic_accounts = Account.where(:section_id => nil)
    generic_accounts.each do |generic_account|
      unit_choices.push([generic_account.name, generic_account.id])
    end

    # Accounts tied to specific sections (section_id non-nil)
    sections = Section.where(:festival_id => 1)
    sections.each do |section|
      unit_choices.push([section.name_en, -1])
      section_accounts = Account.where(:section_id => section.id)
      section_accounts.each do |section_account|
        unit_choices.push([" -> #{section_account.name}", section_account.id])
      end
    end

    # Must parse unit_choices to set disable on accounts with ID=-1
    unit_choices_text = ""
    unit_choices.each do |choice|
      if choice[1] == -1
        unit_choices_text += "<option value=\"-1\" disabled>" + choice[0].to_s + "</option>"
      else
        unit_choices_text += "<option value=\"" + choice[1].to_s + "\">" + choice[0].to_s + "</option>"
      end
    end
    unit_choices_text
  end


end
