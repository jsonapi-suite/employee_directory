require 'rails_helper'

RSpec.describe EmployeeResource, type: :resource do
  describe 'serialization' do
    let!(:employee) { create(:employee) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(employee.id)
      expect(data.jsonapi_type).to eq('employees')
      expect(data.first_name).to eq(employee.first_name)
      expect(data.last_name).to eq(employee.last_name)
      expect(data.age).to eq(employee.age)
      expect(data.created_at).to eq(datetime(employee.created_at))
    end
  end

  describe 'filtering' do
    let!(:employee1) { create(:employee) }
    let!(:employee2) { create(:employee) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: employee2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([employee2.id])
      end
    end
  end

  describe 'sorting' do
    context 'by id' do
      let!(:employee1) { create(:employee) }
      let!(:employee2) { create(:employee) }

      before do
        params[:sort] = '-id'
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([
          employee2.id,
          employee1.id
        ])
      end
    end

    context 'by name' do
      let!(:employee1) { create(:employee, first_name: 'z', last_name: 'a') }
      let!(:employee2) { create(:employee, first_name: 'a', last_name: 'z') }

      before do
        params[:sort] = '-name'
      end

      it 'sorts by last name' do
        render
        expect(d.map(&:id)).to eq([
          employee2.id,
          employee1.id
        ])
      end
    end

    context 'by title' do
      let!(:employee1) { create(:employee) }
      let!(:employee2) { create(:employee) }
      let!(:employee3) { create(:employee) }

      before do
        params[:sort] = '-title'

        create(:position, employee: employee1, historical_index: 2, title: 'a')
        create(:position, employee: employee1, historical_index: 1, title: 'c')
        create(:position, employee: employee2, historical_index: 1, title: 'b')
        create(:position, employee: employee3, historical_index: 1, title: 'z')
      end

      it 'orders by current position title' do
        render
        expect(d.map(&:id)).to eq([
          employee3.id,
          employee1.id,
          employee2.id
        ])
      end
    end

    context 'by department name' do
      let!(:employee1) { create(:employee) }
      let!(:employee2) { create(:employee) }
      let!(:employee3) { create(:employee) }

      before do
        params[:sort] = '-department_name'

        a = create(:department, name: 'a')
        b = create(:department, name: 'b')
        c = create(:department, name: 'c')
        z = create(:department, name: 'z')
        create(:position, employee: employee1, historical_index: 2, department: a)
        create(:position, employee: employee1, historical_index: 1, department: c)
        create(:position, employee: employee2, historical_index: 1, department: b)
        create(:position, employee: employee3, historical_index: 1, department: z)
      end

      it 'orders by current position department name' do
        render
        expect(d.map(&:id)).to eq([
          employee3.id,
          employee1.id,
          employee2.id
        ])
      end
    end
  end

  describe 'sideloading' do
    let!(:employee) { create(:employee) }

    describe 'current_position' do
      let!(:position1) do
        create(:position, historical_index: 2, employee: employee)
      end
      let!(:position2) do
        create(:position, historical_index: 1, employee: employee)
      end

      before do
        params[:include] = 'current_position'
      end

      it 'works' do
        render
        expect(d[0].sideload(:current_position).id).to eq(position2.id)
      end
    end
  end
end
