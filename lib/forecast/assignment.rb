module Forecast
  class Assignment < Base

    def project
      Project.all.find { |project| project_id == project.id }
    end

    def person
      Person.all.find { |person| person_id == person.id }
    end
  end
end
