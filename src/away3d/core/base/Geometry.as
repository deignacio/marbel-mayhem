﻿﻿package away3d.core.base
			if (_dimensionsDirty)
		{
			if (_geometryDirty)
			addEventListener(GeometryEvent.DIMENSIONS_CHANGED, listener, false, 0, true);