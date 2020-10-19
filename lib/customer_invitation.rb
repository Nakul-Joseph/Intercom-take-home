require_relative 'invitation_operations'

class CustomerInvitation
  include InvitationOperations

  attr_reader :office, :customers

  def initialize
    @office = file_read_in(OFFICE_FILEPATH)[0]
    @customers = file_read_in(CUSTOMERS_FILEPATH)
  end

  def list
    invitations = prepare_invitations(office, customers)
    processed_invitations = process_invitations(invitations)
    file_write_to(OUTPUT_FILEPATH, processed_invitations)
  end

  private

  def file_read_in(file_path)
    FileReadWrite.new(file_path,'r').read
  end

  def file_write_to(file_path, content)
    FileReadWrite.new(file_path,'w').write(content)
  end
end
