require 'rails_helper'

RSpec.describe 'v1/employees#update', type: :request do
  describe 'basic update' do
    let!(:employee) { create(:employee, first_name: 'Joe') }

    let(:payload) do
      {
        data: {
          id: employee.id.to_s,
          type: 'employees',
          attributes: { first_name: 'Jane', last_name: 'Simpson', age: '32' }
        }
      }
    end

    it 'updates the attributes and renders the object' do
      expect {
        json_put "/api/v1/employees/#{employee.id}", payload
      }.to change { employee.reload.first_name }.from('Joe').to('Jane')
    end
  end

  describe 'attaching a file' do
    let!(:employee) { create(:employee) }
    let(:file) { fixture_file_upload("#{Rails.root}/spec/fixtures/testphoto.png") }
    let(:encoded_file) { Base64.encode64(file.read) }

    let(:payload) do
      {
        data: {
          id: employee.id.to_s,
          type: 'employees',
          attributes: {
            profile_photo: {
              data: encoded_file,
              filename: 'custom-filename.png'
            }
          }
        }
      }
    end

    it 'persists the file and associates to the employee' do
      json_put "/api/v1/employees/#{employee.id}", payload
      blob = employee.reload.profile_photo.attachment.blob
      persisted = Base64.encode64(blob.download)
      expect(persisted).to eq(encoded_file)
      expect(blob.filename).to eq('custom-filename.png')
    end
  end

  describe 'nested update' do
    def create_position
      create :position,
        employee_id: employee.id,
        department_id: department.id
    end

    let(:method) { 'update' }

    let!(:employee)   { create(:employee, first_name: 'Joe') }
    let!(:position)   { create_position }
    let!(:department) { create(:department) }

    let(:payload) do
      {
        data: {
          id: employee.id.to_s,
          type: 'employees',
          attributes: { first_name: 'updated' },
          relationships: {
            positions: {
              data: [
                { type: 'positions', id: position.id.to_s, method: method }
              ]
            }
          }
        },
        included: [
          {
            type: 'positions',
            id: position.id.to_s,
            attributes: { title: 'updated' },
            relationships: {
              department: {
                data: { type: 'departments', id: department.id.to_s, method: method }
              }
            }
          },
          {
            type: 'departments',
            id: department.id.to_s,
            attributes: { name: 'updated' }
          }
        ]
      }
    end

    it 'updates all objects' do
      json_put "/api/v1/employees/#{employee.id}", payload
      [employee, position, department].each(&:reload)
      expect(employee.first_name).to eq('updated')
      expect(position.title).to eq('updated')
      expect(department.name).to eq('updated')
    end

    context 'when destroying relations' do
      let(:method) { 'destroy' }

      it 'destroys all relationships' do
        json_put "/api/v1/employees/#{employee.id}", payload
        employee.reload
        expect(employee.positions.count).to eq(0)
        expect { position.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect { department.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when disassociating relations' do
      let(:method) { 'disassociate' }

      it 'destroys all relationships' do
        json_put "/api/v1/employees/#{employee.id}", payload
        employee.reload
        expect { position.reload }.to_not raise_error(ActiveRecord::RecordNotFound)
        expect { department.reload }.to_not raise_error(ActiveRecord::RecordNotFound)
        expect(position.department_id).to be_nil
        expect(position.employee_id).to be_nil
      end
    end
  end
end
