class AssetsController < ApplicationController
  
  before_filter :login_required
  
  # GET /assets
  # GET /assets.xml
  def index
    @assets = current_user.assets

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assets }
    end
  end

  # GET /assets/1
  # GET /assets/1.xml
  def show
    @asset = Asset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asset }
    end
  end

  # GET /assets/new
  # GET /assets/new.xml
  def new
    @asset = Asset.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asset }
    end
  end

  # GET /assets/1/edit
  def edit
    @asset = Asset.find(params[:id])
  end

  # POST /assets
  # POST /assets.xml
  def create
    @asset = Asset.new(params[:asset])

    respond_to do |format|
      if params[:Filedata]
        @asset = Asset.new :swf_uploaded_data => params[:Filedata]
        @asset.user = current_user
        @asset.save!

        format.html { render :text => @asset.image.url(:thumb) }
        format.xml  { render :nothing => true }
      else
        if @asset.save
          flash[:notice] = 'Created'
          format.html { redirect_to(@asset) }
          format.xml  { render :xml => @asset, :status => :created, :location => @asset }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /assets/1
  # PUT /assets/1.xml
  def update
    @asset = Asset.find(params[:id])

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        flash[:notice] = 'Updated'
          format.html { redirect_to(@asset) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.xml
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to(assets_url) }
      format.xml  { head :ok }
    end
  end
  
end