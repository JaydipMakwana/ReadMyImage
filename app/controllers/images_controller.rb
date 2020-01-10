class ImagesController < ApplicationController
  before_action :set_image, only: %i[show destroy ocr_processing download_text]
  after_action :ocr_processing, only: %i[create]

  def index
    @images = Image.all
  end

  def show; end

  def new
    @image = Image.new
  end

  def download_text
    name = @image.photo.blob.filename
    send_data @image.ocr_content, :filename => "#{name}.txt"
  end

  def create
    @image = Image.new(image_params)
    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Images was successfully uploaded.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Images was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def ocr_processing
    @photo = @image.photo
    text = MicrosoftOcr.call_service(@photo)
    # text = GoogleCloudVision.get_text(@photo)
    # abc = GoogleCloudVision.classify_text(text)
    @image.update(ocr_content: text, status: 'completed')
  end

  def set_image
    @image = Image.find_by(id: params[:id] || params[:image_id])
  end

  def image_params
    params.require(:image).permit(:status, :photo)
  end
end
