class Rails
  class Railtie
    def self.rake_tasks
    end
  end

  def self.root
    Pathname.new __FILE__
  end
end
