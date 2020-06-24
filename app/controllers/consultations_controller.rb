class ConsultationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :langs_locs, :lang_locs, :lang_loc,
  :langs_types, :lang_types, :lang_type, :langs_periods, :lang_periods, :lang_period, :langs_onlines, :lang_online, :langs_hourlies, :lang_hourly, :langs_singles, :lang_single, :langs_edus, :lang_edu, :langs_acts, :lang_act, :location, :locations]
  before_action :find_consultation, only: [:show, :edit, :update, :destroy]
  before_action :consultation_params, only: [:create]
  # before_action :period_params, only: [:hourly]
  before_action :location_params, only: [:location, :lang_loc]
  before_action :language_params, only: [:lang_locs, :lang_loc, :lang_types, :lang_type,:lang_period, :lang_periods, :lang_online, :lang_hourly,:lang_single, :lang_edu, :lang_act, :location]
  before_action :period_params, only: [:lang_period]
  before_action :type_params, only: [:lang_type]
  skip_after_action :verify_authorized, only: [:langs_locs, :lang_locs, :lang_loc, :langs_types, :lang_types, :lang_type, :langs_periods, :lang_periods, :lang_period, :langs_onlines, :lang_online,
    :langs_hourlies, :lang_hourly, :langs_singles, :lang_single, :langs_edus, :lang_edu, :langs_acts, :lang_act, :locations, :location]
  def index
    #@consultations = Consultation.all
    if params[:query].present?
      # if search request; search_by_x("english") found in MODEL
      @consultations = policy_scope(Consultation.search_by_x(params[:query]).paginate(page: params[:page], per_page: 8) )
    else
      # if no search request; show all consultations
      @consultations = policy_scope(Consultation).paginate(page: params[:page], per_page: 8)
    end

    # @consultations.paginate(page: params[:pages])
# @consultations.each do |c|
# if c.reviews.all.map{|x| [x.star]} == []
# else
# @cons_rstars = c.reviews.all.map{|x| [x.star]}
# @r_stars = @cons_rstars.sum
# @total_rstars = @r_stars.sum
# @total_reviews = @cons_rstars.size
# @avg_star = (@total_rstars / @total_reviews)
# end
# end
# raise

    @consultations.each do |consult|
      @cons_rstars = consult.reviews.all.map{|x| [x.star]}
      # ^ creates and array of review stars ex: [[4],[1]]
      unless @cons_rstars == []
        @r_stars = @cons_rstars.sum
        # ^ produces single array ex: [4,1] not sure why
        @total_rstars = @r_stars.sum
        # ^ SAME as above: @total_rstars = @r_stars.inject(0){|sum,x| sum + x }
        # ^^ sum of all stars ex[4 + 1] = 5
        @total_reviews = @cons_rstars.size
        # total number of reviews
        @avg_star = (@total_rstars / @total_reviews)
      end
    end # end of consultations.each
  end # end of index

  def show
    @appointment = Appointment.new
    @message = Message.new
    @review = Review.new
    @lesson = Lesson.new
    @client = Client.new
    authorize @lesson
    @lesson_op = @consultation.lessons.all.map{|x| [x.lesson_section]}
    @lesson_dow_array = @consultation.lessons.all.map{|x| [x.lesson_dow]}
    @consultation_review_star = @consultation.reviews.all.map{|x| [x.star]}
    # ^ creates and array of review stars ex: [[4],[1]]
    unless @consultation_review_star == []
      @review_stars = @consultation_review_star.sum
      # ^ @total_review_stars produces single array ex: [4,1] not sure why
      @total_review_stars = @review_stars.sum
      # ^ SAME as above: @total_review_stars = @review_stars.inject(0){|sum,x| sum + x }
      # ^^ sum of all stars ex[4 + 1] = 5
      @total_reviews = @consultation_review_star.size
      # ^ total number of reviews with stars ex: 2
      @avg_star = (@total_review_stars / @total_reviews)
    end
    # raise
    # authorize @appointment
    # raise
  end

  def new
    @consultation = Consultation.new
    authorize @consultation
  end

  def create
    @consultation = Consultation.new(consultation_params)
    # raise
    @consultation.user = current_user
    authorize @consultation # authorize then save
    # @consultation.save
    if @consultation.save
      flash[:notice] = "Your class has been created!"
      respond_to do |format|
        format.html { redirect_to dashboard_path }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      flash[:alert] = "Your class was not created. Please try again!"
      respond_to do |format|
        format.html { render :new, consultation: @consultation }
        format.js  # <-- idem
      end
    end
    # redirect_to dashboard_path

  end # end of create

  def edit
  end

  def update
    if @consultation.update(consultation_params)
    # respond_to do |format|
    #     format.html { redirect_to dashboard_path }
    #   end
    flash[:notice] = "Your class has been updated!"
    redirect_to consultation_path(@consultation)
    else
    render :edit
    end
  end

  def destroy
    @consultation.destroy
    flash[:notice] = "Your class has been destroyed!"
    redirect_to dashboard_path
  end

  def langs_locs
    @consultations = policy_scope(Consultation)
    @consult_language_links = []
    @consultations.each do |c|
     unless @consult_language_links.include? c.consult_language
      @consult_language_links << c.consult_language
     end
    end
  end
  def lang_locs
    @consult_lang_group = Consultation.where(consult_language: @consult_lang)
    # @consult_lang is defined in before_action :language_params, only: [:lang_locs]
    @consult_city_links = []
    @consult_lang_group.each do |c|
      unless @consult_city_links.include? c.consult_city
        @consult_city_links << c.consult_city
      end
    end
    # raise
  end
  def lang_loc
    @consult_lang_loc_group = Consultation.where(consult_language: @consult_lang, consult_city: @consult_city).paginate(page: params[:page], per_page: 8)
    # @consult_lang is defined in before_action :language_params, only: [:lang_loc]
    # @consult_city is defined in before_action :location_params, only: [:lang_loc]
raise
  end

  def langs_types
    @consultations = policy_scope(Consultation)
    @consult_language_links = []
    @consultations.each do |c|
      unless @consult_language_links.include? c.consult_language
        @consult_language_links << c.consult_language
      end
    end
  end
  def lang_types
    @consult_lang_group = Consultation.where(consult_language: @consult_lang)
    @consult_type_links = []
    @consult_lang_group.each do |c|
      unless @consult_type_links.include? c.consult_type
        @consult_type_links << c.consult_type
      end
    end
    # raise
  end
  def lang_type
    @consult_lang_type_group = Consultation.where(consult_language: @consult_lang, consult_type: @consult_type).paginate(page: params[:page], per_page: 8)
    # raise
  end

  def langs_periods
    @consultations = policy_scope(Consultation)
    @consult_language_links = []
    @consultations.each do |c|
      unless @consult_language_links.include? c.consult_language
        @consult_language_links << c.consult_language
      end
    end
  end
  def lang_periods
    @consult_lang_group = Consultation.where(consult_language: @consult_lang)
    @consult_period_links = []
    @consult_lang_group.each do |c|
      unless @consult_period_links.include? c.consult_period
        @consult_period_links << c.consult_period
      end
  end
  # raise
  end
  def lang_period
    @consult_period_group = Consultation.where(consult_language: @consult_lang, consult_period: @consult_period).paginate(page: params[:page], per_page: 8)
  end

  def langs_onlines
    @consultations = Consultation.where(consult_env: "online - remote")
    @consult_language_links = []
    @consultations.each do |c|
      unless @consult_language_links.include? c.consult_language
        @consult_language_links << c.consult_language
      end
    end
  end
  def lang_online
    @consult_lang_online_group = Consultation.where(consult_language: @consult_lang, consult_env: "online - remote").paginate(page: params[:page], per_page: 8)
    # raise
  end

  def langs_hourlies
    @consultations = Consultation.where(consult_period: "hourly")
    @consult_language_links = []
    @consultations.each do |c|
      unless @consult_language_links.include? c.consult_language
        @consult_language_links << c.consult_language
      end
    end
  end
  def lang_hourly
    @consult_lang_hourly_group = Consultation.where(consult_language: @consult_lang, consult_period:"hourly").paginate(page: params[:page], per_page: 8)
  end

  def langs_singles
    @consultations = Consultation.where(consult_period: "single-session")
    @consult_language_links = []
    @consultations.each do |c|
      unless @consult_language_links.include? c.consult_language
        @consult_language_links << c.consult_language
      end
    end
  end
  def lang_single
    @consult_lang_single_group = Consultation.where(consult_language: @consult_lang, consult_period: "single-session").paginate(page: params[:page], per_page: 8)
  end

  def langs_edus
    @consultations = Consultation.where(consult_type: "education")
    @consult_language_links = []
    @consultations.each do |c|
      unless @consult_language_links.include? c.consult_language
        @consult_language_links << c.consult_language
      end
    end
  end
  def lang_edu
    @consult_lang_edu_group = Consultation.where(consult_language: @consult_lang, consult_type: "education").paginate(page: params[:page], per_page: 8)
  end

  def langs_acts
    @consultations = Consultation.where(consult_type: "club")
    @consult_language_links = []
    @consultations.each do |c|
      unless @consult_language_links.include? c.consult_language
        @consult_language_links << c.consult_language
      end
    end
  end
  def lang_act
    @consult_lang_act_group = Consultation.where(consult_language: @consult_lang, consult_type: "club").paginate(page: params[:page], per_page: 8)
  end

  def locations
    # skip_authorization
    @consultations = policy_scope(Consultation)
    @consult_language_links = []
    @consultations.each do |c|
      unless @consult_language_links.include? c.consult_language
        @consult_language_links << c.consult_language
      end
    end
# >>>>

  # <<<<<<
    # raise
  end
  def location
    @consult_lang_group = Consultation.where(consult_language: @consult_lang).geocoded
    # raise Test Geocoded
    @consult_lang_group.each do |consult|
      @cons_rstars = consult.reviews.all.map{|x| [x.star]}
      # ^ creates and array of arrays of review stars ex: [[4],[1]]
      unless @cons_rstars == []
        @r_stars = @cons_rstars.sum
        # ^ produces single array ex: [4,1] not sure why
        @total_rstars = @r_stars.sum
        # ^ SAME as above: @total_rstars = @r_stars.inject(0){|sum,x| sum + x }
        # ^^ sum of all stars ex[4 + 1] = 5
        @total_reviews = @cons_rstars.size
        # ^total number of reviews
        @avg_star = (@total_rstars / @total_reviews)
      end
    end # end of @consult_lang_group.each
    @markers = @consult_lang_group.map do |consult_inst|
      # raise
    # raise Test Markers
    # @consultations_address = policy_scope(Consultation.geocoded)
    # @markers = @consultations_address.map do |consult_add|
      # Brackets below for a new object.
      # Each set (lng &lat) is placed in the new object, within the mapped array
      {
        lng: consult_inst.longitude,
        lat: consult_inst.latitude,
        infoWindow: render_to_string(partial: 'info_window', locals: { element: consult_inst }),
        image_url: consult_inst.user.photo.url || 'https://res.cloudinary.com/mattg/image/upload/v1494130069/user-icon.png'
      }
      # => [{:lng=>126.9782914, :lat=>37.5666791},{:lng=>129.8787114, :lat=>40.2632791}]
    end
    # @consult_city_group = Consultation.where(consult_city: @consult_city).paginate(page: params[:page], per_page: 8)
    # location param from Consultations#locations view as link 'cloc_link'
    # @consult_loc from private

  end



  private
  def find_consultation
    @consultation = Consultation.find(params[:id])
    authorize @consultation
  end
  def consultation_params
    params.require(:consultation).permit(:consult_language, :consult_sec_lang, :consult_focus, :consult_period, :consult_type, :consult_demo, :consult_fee, :consult_title, :consult_desc, :consult_city, :address, :consult_mat, :consult_env, :consult_zoom_link)
  end
  def location_params
    @consult_city = params[:consult_city]
  end
  def language_params
    @consult_lang = params[:consult_language]
  end
  def type_params
    @consult_type = params[:consult_type]
  end
  def period_params
    @consult_period = params[:consult_period]
  end
end
