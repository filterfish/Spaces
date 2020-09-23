require_relative 'universe'

def descriptor
  @descriptor ||= Spaces::Descriptor.new(
    repository: 'https://github.com/MarkRatjens/hashicorp.git',
    identifier: 'terrigal',
    branch: 'spaces'
  )
end
