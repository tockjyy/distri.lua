local queue = {
	head = nil,
	tail = nil,
	size = 0,
}

function queue:new(o)
  local o = o or {}   
  setmetatable(o, self)
  self.__index = self
  o.size = 0
  o.head = nil
  o.tail = nil
  return o
end

function queue:Push(node)
    if not self.tail then
        self.head = node
        self.tail = node
	else
		self.tail.__next = node
		self.tail = node
	end
	self.size = self.size + 1
end

function queue:Front()
    if not self.head then
		return nil
	else
		return self.head
	end	
end

function queue:Pop()
    if not self.head then
		return nil
	else
		local node = self.head
		local next = node.__next
		if next == nil then
			self.head = nil
			self.tail = nil
		else
			self.head = next
		end
		self.size = self.size - 1
		node.__next = nil
		return node
	end
end

function queue:Remove(ele)
	local cur = self.head
	local pre = self.head
	while cur do
		if cur == ele then
			self.size = self.size - 1
			if self.size == 0 then
				self.head = nil
				self.tail = nil
			elseif cur == self.head then
				--head
				self.head = cur.__next
			else
				--tail
				pre.__next = nil
				self.tail = pre
			end			
			return
		else
			pre = cur
			cur = cur.__next
		end	
	end	
end

function queue:IsEmpty()
	return self.size == 0
end

function queue:Len()
	return self.size
end

return {
	New = function () return queue:new() end
}
