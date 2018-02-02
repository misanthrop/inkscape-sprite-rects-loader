xml = require 'fast-xml-parser'

module.exports = (source) ->
	@cacheable and @cacheable()
	rects = {}
	j = xml.parse source,
		attrNodeName: '$'
		attrPrefix: ''
		ignoreNonTextNodeAttr: false
		ignoreTextNodeAttr: false
	sprites = j.svg.g.find (g) -> g.$['inkscape:label'] == 'sprites'
	for r in sprites.rect
		names = r.$.id.split '.'
		a = rects
		for name, i in names
			a[name] ?= {}
			if i == names.length - 1
				a[name] = [+r.$.x, +r.$.y, +r.$.width, +r.$.height].map Math.round
			a = a[name]
	@callback null, "module.exports = " + JSON.stringify rects
