class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!,only: [:create,:edit,:update,:index]

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      flash[:genre_create_error] = "ジャンル名を入力してください"
      @genres = Genre.all
      redirect_to admin_genres_path
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      flash[:genre_edit_error] = "ジャンル名を入力してください"
      @genre = Genre.find(params[:id])
      redirect_to edit_admin_genre_path(@genre)
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:genre)
  end
end