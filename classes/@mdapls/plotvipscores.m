function varargout = plotvipscores(obj, varargin)

   nResp = 1;
   if nargin > 1
      if isnumeric(varargin{1})
         nResp = varargin{1};
         varargin(1) = [];
      elseif ischar(varargin{1}) && any(ismember(obj.vipscores.colNames, varargin{1}))
         nResp = varargin{1};
         varargin(1) = [];
      end
   end
   
   i = find(strcmp(varargin, 'Type'), 1);
   if ~isempty(i)
      type = varargin{i + 1};
      varargin(i:i+1) = [];
   else
      type = 'bar';
   end
   
   [mr, varargin] = getarg(varargin, 'Marker');
   if isempty(mr)
      mr = '.';
   end   

   
   if strcmp(type, 'bar')   
      h = bar(obj.vipscores(:, nResp)', varargin{:});
   elseif strcmp(type, 'line')   
      h = plot(obj.vipscores(:, nResp)', varargin{:}, 'Marker', mr);
   else
      error('Wrong plot type!');
   end
   
   title('VIP scores')
   
   xl = xlim();
   xl(1) = 0;
   xlim(xl);
   
   if nargout > 0
      varargout{1} = h.plot;
   end   
end
