#ณัฐนันท์ ประพันธ์ศิริ 5310613194
#นัฐพร กำศิริพิมาน 5310611065

class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #แยก case ว่าจะแสดงผลเรียงตาม title หรือ release date
    case params[:sortby]||session[:sortby]
    when 'title'
      ordering,@title = {:order => :title}, 'hilite'
    when 'release_date'
      ordering,@date = {:order => :release_date}, 'hilite'
    end
    #นำ array ที่เก็บ rate ไว้มาเก็บไว้ที่ @all_ratings
    @all_ratings = Movie.all_ratings
    #เก็บ parameter rating ที่ user ได้เลือกไว้
    @selectrating = params[:ratings]||session[:ratings]||{}
    #ถ้าค่าที่รับเข้ามาจาก user กับค่าที่เก็บไว้ใน session ไม่ตรงกันให้เปลี่ยนค่า session เป็นค่าที่รับมาใหม่
      if params[:sortby] != session[:sortby] || params[:ratings] != session[:ratings]
      	session[:sortby] = params[:sortby]||session[:sortby]
      	session[:ratings] = @selectrating
      	#ทำการ redirect ไปตามค่าที่ได้รับเข้ามาใหม่
      	redirect_to :sortby => params[:sortby]||session[:sortby], :ratings => @selectrating 
      end
      #ทำการแสดงผลข้อมูลตาม rate ที่ถูกเลือก และเรียงตามที่กำหนดไว้
    @movies = Movie.find_all_by_rating(@selectrating.keys, ordering)
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
