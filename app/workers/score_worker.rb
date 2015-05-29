class ScoreWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    daily.hour_of_day(0).minute_of_hour(1)
  end

  def perform
    candidates = Post.all.reject { |post| post.score == 0 }
    avg_score = candidates.reduce(0) { |total, post| total + post.score } / candidates.length
    max_score = candidates.max_by { |post| post.score }.score
    Post.all.each do |post|
      post.popular = post.score > avg_score
      post.top = post.score == max_score
      post.save!
    end
  end
end
