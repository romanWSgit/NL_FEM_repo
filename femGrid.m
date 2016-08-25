classdef femGrid
%descripton....TODO

    properties
    % define the properties of the class here, (like fields of a struct)
        nodesBound;
        elements;
        
%         hour;
%         day;
%         month;
%         year;
    end
   
     methods
     % methods, including the constructor are defined in this block
        function obj = femGrid(nodesBound,elements)
        % class constructor
            if(nargin > 0)
                 obj.nodesBound=nodesBound;
                 obj.elements=elements;
                 
            end
        end
        
       % Darstellen des Netzes
%         function obj = printNodes(obj)
%             for i=1:4
%                obj.nodes
%             end
%         end
        
         % Darstellen des Netzes mit Elementsnummern
%         function obj = printNodes(obj)
%             for i=1:4
%                obj.nodes
%             end
%         end
        
    end
end
