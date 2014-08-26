class CourseCollection < CuratedCollection
  include WithNestedMembers
  include PowerPoint

  def parent
    ActiveFedora::Base.where(member_ids_ssim: self.id).first
  end

  def ancestors_and_self(acc=[])
    if root?
      acc
    else
      self.parent.ancestors_and_self([self] + acc)
    end
  end

  after_create :add_to_root_collection

  def add_to_root_collection
    return if root?
    CourseCollection.root.tap do |root|
      root.member_ids = [id] + root.member_ids
      root.save!
    end
  end

  # Sets the default value for the edit form.
  def type
    'course'
  end

  def creator
    super.first
  end

  ROOT_PID = 'tufts:root_collection'

  def root?
    self.pid == ROOT_PID
  end

  class << self
    def root
      root = CourseCollection.where(id: ROOT_PID).first
      root ||= CourseCollection.create!(pid: ROOT_PID, title: 'Root')
    end
  end

end
