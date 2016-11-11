require 'date'

module Forecast
  class Assignment < Base

    def project
      Project.all.find { |project| project_id == project.id }
    end

    def person
      Person.all.find { |person| person_id == person.id }
    end

    def half_day?
      return unless allocation

      start_date == end_date && allocation <= 4.hours
    end

    def start_date
      Date.parse(@attributes[:start_date])
    end

    def end_date
      Date.parse(@attributes[:end_date])
    end
  end
end
