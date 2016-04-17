module ActiveRecordExtension
  extend ActiveSupport::Concern

  module ClassMethods

    # Updates an object (or multiple objects) and saves it to the database. The resulting object is returned whether the object was saved successfully to the database or not.
    #
    # @param ids [Array] an array of ids
    # @param attributes [Array] an array of attribute hashes
    # @return [Object] the object.
    def update!(ids, attributes)
      update_manager = Arel::UpdateManager.new

      resources = self.arel_table

      attribute_hash = {}

      resources_id = resources[:id]

      attributes.each_with_index do |attribute, index|
        attribute.each do |key, value|
          attribute_hash[key] = Arel::Nodes::Case.new(resources_id) unless attribute_hash[key]
          attribute_hash[key].when(ids[index]).then(value)
        end
      end

      attribute_array = attribute_hash.map do |attribute, values|
        attribute = resources[attribute.to_sym]
        [attribute, Arel::Nodes::SqlLiteral.new(values.else(attribute).to_sql)]
      end

      update_manager.table(resources).where(resources_id.in(ids))
      ActiveRecord::Base.connection.execute(update_manager.set(attribute_array).to_sql)

      self
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecordExtension)
