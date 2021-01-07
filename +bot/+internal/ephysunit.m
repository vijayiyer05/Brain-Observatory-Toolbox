classdef ephysunit < bot.internal.ephysitem
   properties (SetAccess = private)
      session;
      channel;
      probe;
   end
   
   methods
      function unit = ephysunit(unit_id, oManifest)
         % - Handle "no arguments" usage
         if nargin == 0
            return;
         end
         
         % - Handle a vector of unit IDs
         if ~istable(unit_id) && (numel(unit_id) > 1)
            for nIndex = numel(unit_id):-1:1
               unit(nIndex) = bot.internal.ephysunit(unit_id(nIndex), oManifest);
            end
            return;
         end
         
         % - Assign metadata
         unit = unit.check_and_assign_metadata(unit_id, oManifest.tEPhysUnits, 'unit');
         
         % - Get a handle to the corresponding experimental session
         unit.session = oManifest.session(unit.metadata.ephys_session_id);
         unit.channel = oManifest.channel(unit.metadata.ephys_channel_id);
         unit.probe = oManifest.probe(unit.metadata.ephys_probe_id);
      end
   end
end