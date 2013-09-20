module AnimalsHelper
  
  def documents_legend_title(number)
    pluralize(number, 'document') + ' uploaded'
  end
  
end
