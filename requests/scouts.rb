module Scouts

  def self.post(payload)
    RestClient.post 'http://gouden11.hln.be/j2ee_g11/scouts/table.action',
                    payload,
                    {content_type: :'application/x-www-form-urlencoded'}
  end

end