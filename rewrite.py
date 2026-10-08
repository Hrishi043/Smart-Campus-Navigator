import re

def main():
    scratch_file = '/Users/hrishikeshps/.gemini/antigravity/brain/9b76a201-ca0f-405d-bc72-45cecd59b7bd/scratch/map.dart'
    with open(scratch_file, 'r') as f:
        content = f.read()

    # We need to keep MapStyleMode for compatibility (it is defined in the file).
    # We replace paint method:
    paint_replacement = """  @override
  void paint(Canvas canvas, Size size) {
    _drawCollegeMap(canvas, size);
    if (activeRoute != null) {
      _drawNavigationRoute(canvas, size);
    }
    if (userLocationOffset != null) {
      _drawUserLocation(canvas, size);
    }
    if (selectedPlace != null) {
      _drawSelectedPin(canvas, size);
    }
  }"""
    content = re.sub(r'  @override\n  void paint\(Canvas canvas, Size size\) \{.*?(?=\n  void _drawCollegeMap)', paint_replacement, content, flags=re.DOTALL)

    # Remove non-collegeMap styles implementations
    # From `// 1. CAMPUS BACKGROUND` to right before `// 4. NAVIGATION ROUTE`
    content = re.sub(r'  // ---------------------------------------------------------------------------\n  // 1\. CAMPUS BACKGROUND.*?  // ---------------------------------------------------------------------------\n  // 4\. NAVIGATION ROUTE', '  // ---------------------------------------------------------------------------\n  // 4. NAVIGATION ROUTE', content, flags=re.DOTALL)
    
    # Wait, if we remove `_draw3DBuildings`, we should also remove `// 5. 3D BUILDING BLOCKS & MODELS` up to `// 6. USER LOCATION PIN`
    content = re.sub(r'  // ---------------------------------------------------------------------------\n  // 5\. 3D BUILDING BLOCKS & MODELS.*?  // ---------------------------------------------------------------------------\n  // 6\. USER LOCATION PIN', '  // ---------------------------------------------------------------------------\n  // 6. USER LOCATION PIN', content, flags=re.DOTALL)

    # Clean up ternary operators branching on styleMode == MapStyleMode.collegeMap
    content = content.replace("final mapPosition = styleMode == MapStyleMode.collegeMap\n          ? _collegeMapNodePositions[nodes[i].id]\n          : null;", "final mapPosition = _collegeMapNodePositions[nodes[i].id];")
    content = content.replace("final mapPosition = styleMode == MapStyleMode.collegeMap\n        ? _collegeMapNodePositions[nodes[i].id]\n        : null;", "final mapPosition = _collegeMapNodePositions[nodes[i].id];")
    content = content.replace("final mapPosition = styleMode == MapStyleMode.collegeMap\n          ? _collegeMapNodePositions[nodes.first.id]\n          : null;", "final mapPosition = _collegeMapNodePositions[nodes.first.id];")
    content = content.replace("final mapPosition = styleMode == MapStyleMode.collegeMap\n          ? _collegeMapNodePositions[nodes.last.id]\n          : null;", "final mapPosition = _collegeMapNodePositions[nodes.last.id];")
    content = content.replace("final mapPosition = styleMode == MapStyleMode.collegeMap\n        ? _collegeMapFeatures\n              .where((feature) => feature.placeId == place.id)\n              .firstOrNull\n              ?.center\n        : null;", "final mapPosition = _collegeMapFeatures\n              .where((feature) => feature.placeId == place.id)\n              .firstOrNull\n              ?.center;")
    
    # Wait, there are more! Let's just do regex for ternary involving MapStyleMode.collegeMap
    content = re.sub(r'widget\.styleMode == MapStyleMode\.collegeMap\n\s*\?\s*([^\n]+)\n\s*:\s*[^\n]+', r'\1', content)
    content = re.sub(r'styleMode == MapStyleMode\.collegeMap\n\s*\?\s*([^\n]+)\n\s*:\s*[^\n]+', r'\1', content)
    
    content = re.sub(r'widget\.styleMode == MapStyleMode\.collegeMap \? 1179\.0 : 1000\.0', '1179.0', content)
    content = re.sub(r'widget\.styleMode == MapStyleMode\.collegeMap \? 768\.0 : 1000\.0', '768.0', content)
    content = re.sub(r'styleMode == MapStyleMode\.collegeMap \? 0\.48 : tilt', '0.48', content)
    content = content.replace("widget.styleMode != MapStyleMode.collegeMap || _viewportSize.isEmpty", "_viewportSize.isEmpty")

    # Camera resets
    content = re.sub(r'final isCollegeMap = widget\.styleMode == MapStyleMode\.collegeMap;\n\s*_animateCameraTo\(\n\s*targetX: isCollegeMap \? 589\.5 : 520\.0,\n\s*targetY: isCollegeMap \? 384\.0 : 480\.0,', '_animateCameraTo(\n      targetX: 589.5,\n      targetY: 384.0,', content)
    
    # didUpdateWidget simplification
    content = re.sub(r'if \(widget\.styleMode != oldWidget\.styleMode\) \{.*?\} else if', 'if', content, flags=re.DOTALL)
    
    # initState initialization
    content = re.sub(r'if \(widget\.styleMode == MapStyleMode\.collegeMap\) \{\n\s*_camX = 589\.5;\n\s*_camY = 384;\n\s*_zoom = _overviewZoom;\n\s*\}', '_camX = 589.5;\n            _camY = 384;\n            _zoom = _overviewZoom;', content)

    # Building labels inside drawCollegeBuildings or something?
    # Actually _draw3DBuildings is removed, but we still need `_drawCollegeBuilding` which uses `_drawBuildingLabel`?
    # No, `_drawCollegeBuilding` is self-contained. It doesn't call `_drawBuildingLabel`. It just draws the building. Labels are drawn by `_drawCollegeMapLabels` which we kept!

    # Write out to target file
    with open('lib/widgets/campus_3d_map.dart', 'w') as f:
        f.write(content)

main()
