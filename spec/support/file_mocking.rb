module FileMocking
  def pretend_file_exists(filename)
    allow(File).to receive(:exist?)
    allow(File).to receive(:open).and_call_original
    allow(File).to receive(:exist?).with(filename).and_return(true)
    allow(File).to receive(:open).with(filename)
  end

  def pretend_file_doesnt_exist(filename)
    allow(File).to receive(:exist?)
    allow(File).to receive(:open).and_call_original
    allow(File).to receive(:exist?).with(filename).and_return(false)
    allow(File).to receive(:open).with(filename).and_raise(Errno::ENOENT)
  end

  def expect_to_write(filename, content = nil)
    file_obj = double('file_obj')
    expect(File).to receive(:open).with(filename, 'w').and_yield(file_obj)
    if content.nil?
      expect(file_obj).to receive(:write).once
    else
      expect(file_obj).to receive(:write).with(content).once
    end
  end
end
