module ApplicationHelper
  def component(name, context: nil, **args, &block)
    return render_component_in(context, name, **args, &block) if context

    render component_class_for(name).new(**args), &block
  end

  def render_component_in(context, name, **args, &block)
    component_class_for(name).new(**args).render_in(context, &block)
  end

  private

  def component_class_for(path)
    name, namespace = path.to_s.split('/').reverse

    file_name = "#{name}_component"
    component_name = file_name.classify
    namespace ||= namespace(file_name)
    return "#{namespace.capitalize}::#{component_name}".constantize unless namespace == 'components'

    component_name.constantize
  end

  def namespace(file_name)
    file_path = component_path(file_name)
    File.dirname(file_path).split('/').last
  end

  def component_path(file_name)
    Dir.glob(File.join(Rails.root, 'app', 'components', '**', file_name + ".rb")).first
  end
end
