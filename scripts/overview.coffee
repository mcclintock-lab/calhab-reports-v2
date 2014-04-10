ReportTab = require 'reportTab'
templates = require '../templates/templates.js'
_partials = require '../node_modules/seasketch-reporting-api/templates/templates.js'
partials = []
for key, val of _partials
  partials[key.replace('node_modules/seasketch-reporting-api/', '')] = val

class OverviewTab extends ReportTab
  name: 'Overview'
  className: 'overview'
  template: templates.overview
  dependencies: [
    'UrchinAreas'
  ]
  

  render: () ->
    # create random data for visualization
    urchinAreas = @recordSet('UrchinAreas', 'UrchinAreas').toArray()

    # setup context object with data and render the template from it
    context =
      sketch: @model.forTemplate()
      sketchClass: @sketchClass.forTemplate()
      attributes: @model.getAttributes()
      admin: @project.isAdmin window.user
      urchinAreas: urchinAreas
    

    @$el.html @template.render(context, partials)
    @enableLayerTogglers()
    
module.exports = OverviewTab