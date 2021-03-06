# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strict
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/dry-events/all/dry-events.rbi
#
# dry-events-0.2.0

module Dry
end
module Dry::Events
  include Dry::Core::Constants
end
class Dry::Events::Event
  def [](name); end
  def id; end
  def initialize(id, payload); end
  def listener_method; end
  def payload(data = nil); end
  def self.new(id, payload = nil); end
  def to_h; end
  def to_hash; end
  include Anonymous_Dry_Equalizer_44
  include Dry::Equalizer::Methods
end
module Anonymous_Dry_Equalizer_44
  def cmp?(comparator, other); end
  def hash; end
  def inspect; end
end
class Dry::Events::Event::InvalidEventNameError < StandardError
  def initialize; end
end
class Dry::Events::Bus
  def attach(listener, filter); end
  def can_handle?(object_or_event_id); end
  def detach(listener); end
  def events; end
  def initialize(events: nil, listeners: nil); end
  def listeners; end
  def process(event_id, payload); end
  def publish(event_id, payload); end
  def subscribe(event_id, filter, &block); end
  def subscribed?(listener); end
end
class Dry::Events::Filter
  def build_checks(filter, checks = nil, keys = nil); end
  def call(payload = nil); end
  def checks; end
  def compare(path, predicate, payload); end
  def initialize(filter); end
  def predicate(value); end
end
class Dry::Events::PublisherAlreadyRegisteredError < StandardError
  def initialize(id); end
end
class Dry::Events::InvalidSubscriberError < StandardError
  def initialize(object_or_event_id); end
end
class Dry::Events::Publisher < Module
  def id; end
  def included(klass); end
  def initialize(id); end
  def self.[](id); end
  def self.registry; end
  include Anonymous_Dry_Equalizer_45
  include Dry::Equalizer::Methods
end
module Anonymous_Dry_Equalizer_45
  def cmp?(comparator, other); end
  def hash; end
  def inspect; end
end
module Dry::Events::Publisher::ClassMethods
  def events; end
  def listeners; end
  def new_bus; end
  def register_event(event_id, payload = nil); end
  def subscribe(event_id, filter_hash = nil, &block); end
end
module Dry::Events::Publisher::InstanceMethods
  def __bus__; end
  def process(event_id, payload = nil, &block); end
  def publish(event_id, payload = nil); end
  def register_event(event_id, payload = nil); end
  def subscribe(object_or_event_id, filter_hash = nil, &block); end
  def subscribed?(listener); end
  def trigger(event_id, payload = nil); end
  def unsubscribe(listener); end
end
