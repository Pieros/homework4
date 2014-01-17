#ณัฐนันท์ ประพันธ์ศิริ 5310613194
#นัฐพร กำศิริพิมาน 5310611065

class Movie < ActiveRecord::Base
	#สร้างตัวแปร instanceสำหรับ class Movie เป็น Array ที่เก็บ rating ไว้
def self.all_ratings
	['G','PG','PG-13','R']
end
end
