module Forecast
  class Project < Base

    def assignments(conditions = {})
      Assignment.all(conditions).
        select { |assignment| assignment.project_id == id }
    end
  end
end
