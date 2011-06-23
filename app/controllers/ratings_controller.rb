class RatingsController < ApplicationController
  # GET /ratings
  # GET /ratings.xml
  def index  
	@ratings = Rating.where('user_id=?',current_user.id).order("created_at DESC")
	
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ratings }
    end
  end

  # GET /ratings/1
  # GET /ratings/1.xml
  def show
    @rating = Rating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rating }
    end
  end

  # GET /ratings/new
  # GET /ratings/new.xml
  def new
    @rating = Rating.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rating }
    end
  end

  # GET /ratings/1/edit
  def edit
    @rating = Rating.where(:user_id=>current_user.id).where(:id=>params[:id]).first
	if @rating.nil?
		#notify[:notice] => 'Cheak!'
		redirect_to :ratings
	end
  end

  # POST /ratings
  # POST /ratings.xml
  def create
    @rating = Rating.new(params[:rating])
	@rating.user = current_user
	
    respond_to do |format|
      if @rating.save
		msg = @rating.value.to_s
		msg=msg+", for " +@rating.description unless (@rating.description.nil? or @rating.description.empty?)

        flash[:notice] = 'Rating '+msg+' was successfully created.'
		
        format.html { redirect_to(ratings_url) }
        format.xml  { render :xml => @rating, :status => :created, :location => @rating }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ratings/1
  # PUT /ratings/1.xml
  def update
    @rating = Rating.where(:user_id=>current_user.id).where(:id=>params[:id]).first #todo-protect from id?

    respond_to do |format|
      if @rating.update_attributes(params[:rating])
        flash[:notice] = 'Rating was successfully updated.'
		
        format.html { redirect_to(@rating) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.xml
  def destroy
    @rating = Rating.find(params[:id])
    #@rating.destroy

    respond_to do |format|
      format.html { redirect_to(ratings_url) }
      format.xml  { head :ok }
    end
  end
end
