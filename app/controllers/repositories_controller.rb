# frozen_string_literal: true

class RepositoriesController < ApplicationController
  before_action :set_repository, only: %i[show edit update destroy]
  before_action { authorize! }

  def index
    @repositories = repositories
  end

  def show; end

  def new
    @repository = Repository.new
  end

  def edit; end

  def create
    @repository = Repository.new(repository_params)

    respond_to do |format|
      if @repository.save
        format.html { redirect_to repository_url(@repository) }
        format.json { render :show, status: :created, location: @repository }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @repository.update(repository_params)
        format.html { redirect_to repository_url(@repository) }
        format.json { render :show, status: :ok, location: @repository }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @repository.destroy

    respond_to do |format|
      format.html { redirect_to repositories_url }
      format.json { head :no_content }
    end
  end

  private

  def set_repository
    @repository = repositories.find(params[:id])
  end

  def repositories
    @repositories ||= authorized_scope(Repository.all)
  end

  def repository_params
    params.require(:repository).permit(:name, :branch, :status)
  end
end
