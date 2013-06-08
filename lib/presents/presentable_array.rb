require 'forwardable'

class PresentableArray
  
  include Enumerable
  extend Forwardable

  def initialize ( values = [] )
    @values = values
  end
  
  def_delegators :@values, :<<, :[], :[]=, :last
  def_delegator :@values, :<<, :add
  
  # Public: Render a context for each element in the view to wrap a model with a presenter.
  # 
  # Examples
  #
  #   <% @users.present_each do |user_presenter| %>
  #     <%= user_presenter.do_presenter_method %>
  #     <%= user_presenter.do_model_method %>
  #   <% end %>
  #
  # Returns each presenter for the model.
  def present_each(&block)
    @values.each do |value|
      cls ||= "#{value.class}Presenter".constantize
      presenter = cls.new(value, self)
      yield presenter if block_given?
    end
  end
  
end

class Array
  def present_each(&block)
    PresentableArray.new(self).present_each(&block)
  end
end