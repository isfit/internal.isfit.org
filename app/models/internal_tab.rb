# == InternalTab
#
# Inneholder hele navigasjonssystemet på internal.isfit.org. Denne er nøstet slik ved bruk av ancestry - gem, slik at en link kan ha flere underliggende linker.
# controller-attributtet er satt til controlleren som underscore-typet. Eksempel: En internal-tab som lenker til RoomBookingController, har room_bookings lagret i controller-atributtet. Dette er gjort for å enklest mulig lage url for denne InternalTab vha. url_for hjelperen
class InternalTab < ActiveRecord::Base
  has_ancestry
end
