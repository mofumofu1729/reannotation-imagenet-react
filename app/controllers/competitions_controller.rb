class CompetitionsController < ApplicationController
  
  def running
    running_competition = Competition.
                            where(finished: nil).
                            where('starts_at < ?', Time.current).
                            where('ends_at > ?', Time.current).
                            order('starts_at').
                            first
    res = {}
    if running_competition
      res[:is_running] = true
      res[:starts_at] = running_competition.starts_at
      res[:ends_at] = running_competition.ends_at
    else
      res[:is_running] = false
      res[:starts_at] = nil
      res[:ends_at] = nil
    end

    render json: res
    end

  def next
    next_competition = Competition.
                            where(finished: nil).
                            where('starts_at > ?', Time.current).
                            order('starts_at').
                            first
    res = {}
    if next_competition
      res[:has_next] = true
      res[:starts_at] = next_competition.starts_at
      res[:ends_at] = next_competition.ends_at
    else
      res[:has_next] = false
      res[:starts_at] = nil
      res[:ends_at] = nil
    end

    render json: res
  end
end
