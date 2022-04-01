class ChangelogsController < ApplicationController
  before_action :set_changelog, only: %i[show edit update destroy]

  def index
    @changelogs = Changelog.all
  end

  def show
  end

  def new
    @changelog = Changelog.new
  end

  def edit
  end

  def create
    @changelog = Changelog.new(changelog_params)

    respond_to do |format|
      if @changelog.save
        format.html { redirect_to changelog_url(@changelog), notice: 'Changelog was successfully created.' }
        format.json { render :show, status: :created, location: @changelog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @changelog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @changelog.update(changelog_params)
        format.html { redirect_to changelog_url(@changelog), notice: 'Changelog was successfully updated.' }
        format.json { render :show, status: :ok, location: @changelog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @changelog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @changelog.destroy

    respond_to do |format|
      format.html { redirect_to changelogs_url, notice: 'Changelog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_changelog
      @changelog = Changelog.find(params[:id])
    end

    def changelog_params
      params.require(:changelog).permit(:title, :body)
    end
end
