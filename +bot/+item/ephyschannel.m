classdef ephyschannel < bot.item.abstract.Item
%
% Represent direct, linked, and derived data for a Visual Coding Neuropixels dataset [1] channel item.
%
% [1] Copyright 2019 Allen Institute for Brain Science. Visual Coding Neuropixels dataset. Available from: https://portal.brain-map.org/explore/circuits/visual-coding-neuropixels
% 
   
    %% PROPERTIES - VISIBLE 
    properties (SetAccess = private)
      units;
      session;
      probe;
    end
   
    %% PROPERTIES - HIDDEN 
        
    % SUPERCLASS IMPLEMENTATION (bot.item.abstract.Item)
    properties (Hidden, Access = protected, Constant)
        MANIFEST_NAME = "ephys";
        MANIFEST_TABLE_NAME = "channels";
    end        
    
    properties (Hidden, Access = protected)
        CORE_PROPERTIES = string.empty(1,0);
        LINKED_ITEM_PROPERTIES = ["session" "probe" "units"];
    end
   
    %% LIFECYCLE
    
    % CONSTRUCTOR
    methods
        function obj = ephyschannel(itemIDSpec)
   
            % Superclass construction
            obj = obj@bot.item.abstract.Item(itemIDSpec);
            
            % Assign linked Item tables (downstream) 
            obj.units = obj.manifest.ephys_units(obj.manifest.ephys_units.ephys_channel_id == obj.id, :);            
            
            % Assign linked Item objects (upstream)
            obj.probe = bot.probe(obj.info.ephys_probe_id);                        
            obj.session = bot.session(obj.info.ephys_session_id);
        end
    end
end

