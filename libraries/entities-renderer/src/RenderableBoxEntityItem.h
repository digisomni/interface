//
//  RenderableBoxEntityItem.h
//  libraries/entities-renderer/src/
//
//  Created by Brad Hefta-Gaub on 8/6/14.
//  Copyright 2014 High Fidelity, Inc.
//
//  Distributed under the Apache License, Version 2.0.
//  See the accompanying file LICENSE or http://www.apache.org/licenses/LICENSE-2.0.html
//

#ifndef hifi_RenderableBoxEntityItem_h
#define hifi_RenderableBoxEntityItem_h

#include <BoxEntityItem.h>
#include "RenderableDebugableEntityItem.h"
#include "RenderableEntityItem.h"

class RenderableBoxEntityItem : public BoxEntityItem {
public:
    static EntityItemPointer factory(const EntityItemID& entityID, const EntityItemProperties& properties);

    RenderableBoxEntityItem(const EntityItemID& entityItemID, const EntityItemProperties& properties) :
        BoxEntityItem(entityItemID, properties)
        { }

    virtual void render(RenderArgs* args);

    virtual bool canRenderInScene() { return true; } // we use our _renderHelper to render in scene
    virtual bool addToScene(EntityItemPointer self, std::shared_ptr<render::Scene> scene) { return _renderHelper.addToScene(self, scene); }
    virtual void removeFromScene(EntityItemPointer self, std::shared_ptr<render::Scene> scene) { _renderHelper.removeFromScene(self, scene); }
private:
    SingleRenderableEntityItem _renderHelper;
};


#endif // hifi_RenderableBoxEntityItem_h
