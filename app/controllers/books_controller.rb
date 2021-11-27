class BooksController < ApplicationController
  before_action :ensure_correct_user,{only: [:edit, :update]}

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @comment = BookComment.new
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    if current_user != @book.user
      redirect_to books_path
    end
  end

  def search
    selection = params[:keyword]
    @books = Book.sort(selection)
  end

  private

  def book_params
    params.require(:book).permit(:title, :image, :body, :rate)
  end

  def sort_params
    params.permit(:sort)
  end

end
