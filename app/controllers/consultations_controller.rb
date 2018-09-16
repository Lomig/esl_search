class ConsultationsController < ApplicationController
  before_action :find_consultation, only: [:show, :edit, :update, :destroy]
  before_action :consultation_params, only: [:create]
  def index
    #@consultations = Consultation.all
    @consultations = policy_scope(Consultation)
  end

  def show
    @appointment = Appointment.new
    @message = Message.new
    @review = Review.new
    @lesson = Lesson.new
    authorize @lesson
    @lesson_op = @consultation.lessons.all.map{|x| [x.lesson_section]}
    @consultation_review_star = @consultation.reviews.all.map{|r| [r.star]}
    # ^ creates and array of review stars ex: [[4],[1]]
    @review_stars = @consultation_review_star.sum
    # ^ @total_review_stars produces single array ex: [4,2] not sure why
    @total_review_stars = @review_stars.sum
    # ^ SAME as above: @total_review_stars = @review_stars.inject(0){|sum,x| sum + x }
    # ^^ sum of all stars ex[4 + 1] = 5
    @total_reviews = @consultation_review_star.size
    # ^ total number of reviews with stars ex: 2
    @avg_star = (@total_review_stars / @total_reviews)
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
      respond_to do |format|
        format.html { redirect_to dashboard_path }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'pages/dashboard' }
        format.js  # <-- idem
      end
    end
    # redirect_to dashboard_path

  end # end of create

  def edit
  end

  def update
  end

  def destroy
    @consultation.destroy
    redirect_to dashboard_path
  end

  private
  def find_consultation
    @consultation = Consultation.find(params[:id])
    authorize @consultation
  end
  def consultation_params
    params.require(:consultation).permit(:consult_language, :consult_sec_lang, :consult_native_speaker, :consult_focus, :consult_period, :consult_dur, :consult_type, :consultfee, :consult_title, :consult_desc, :consult_location, :matincluded, :consult_dow=>[])
  end
end
