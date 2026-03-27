#include "ecmcStrucppLogicWrapper.hpp"
#include "generated/machine_epics_exports.hpp"
#include "machine.hpp"

ECMC_STRUCPP_DECLARE_LOGIC_API_WITH_EXPORTS(
  "machine_logic",
  strucpp::Program_MACHINE,
  strucpp::locatedVars,
  ecmcStrucppExports::initProgram_MACHINEExports);
