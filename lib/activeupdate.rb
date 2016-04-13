module ActiveRecordExtension
  extend ActiveSupport::Concern

  module ClassMethods

    # Updates an object (or multiple objects) and saves it to the database. The resulting object is returned whether the object was saved successfully to the database or not.
    #
    # @param resources_hash [Hash], a hash of resources, { '0' => { 'id' => 1, 'attribute' => 'test' }, '1'  => { 'id' => 2, 'attribute' => 'cheese' } }
    # @return [Object], the object.
    def update!(resources_hash = nil)
      return self unless resources_hash

      update_manager = Arel::UpdateManager.new
      resources = self.arel_table

      attribute_values = []

      first_resources_hash = resources_hash.delete('0')
      first_resources_id = first_resources_hash.delete('id').to_i

      resource_ids = []

      resource_ids << first_resources_id
      resources_id = resources[:id]

      first_resources_hash.each do |attribute, value|
        attribute_values << [resources[attribute.to_sym], Arel::Nodes::Case.new(resources_id).when(first_resources_id).then(value)]
      end

      resources_hash.each do |_, resource_attributes|
        resource_id = resource_attributes.delete('id').to_i
        resource_ids << resource_id

        resource_attributes.each_with_index do |(_, value), index|
          attribute_values[index][1].when(resource_id).then(value)
        end
      end

      attribute_values.map! do |attribute, values|
        [attribute, Arel::Nodes::SqlLiteral.new(values.to_sql)]
      end

      update_manager.table(resources).where(resources_id.in(resource_ids))
      ActiveRecord::Base.connection.execute(update_manager.set(attribute_values).to_sql)

      self
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecordExtension)
