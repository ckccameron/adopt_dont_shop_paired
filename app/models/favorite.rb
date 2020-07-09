class Favorite < Pet

  @favorites = Pet.where(favorite_status: true).count
end
