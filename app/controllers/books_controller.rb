class BooksController < ApplicationController
  before_action :set_book, only: %i[show destroy]
  def index
    @books = Book.all
    if params[:query].present?
      sql_subquery = "title ILIKE :query OR author ILIKE :query"
      @books = @books.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
    @reviews = @book.reviews
    @avg_review_score = avg_review_score
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      redirect_to book_path(@book)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, status: :see_other
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :details, :author, :year, :photo)
  end

  def avg_review_score
    reviews = @book.reviews
    reviews_scores = reviews.pluck(:rating)
    reviews_scores.sum.fdiv(reviews_scores.size)
  end
end
