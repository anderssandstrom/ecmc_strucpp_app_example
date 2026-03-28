#include "machine_helper.hpp"

#include "ecmcStrucppLogicWrapper.hpp"
#include "generated/machine.hpp"

#if __has_include("generated/machine_epics_exports.hpp")
#include "generated/machine_epics_exports.hpp"
#define ECMC_STRUCPP_EXPORT_INIT_FN ecmcStrucppExports::initProgram_MACHINEExports
#endif

namespace {
[[maybe_unused]] const char* kLogicNameExample = machineLogicExampleName();
}

#ifdef ECMC_STRUCPP_EXPORT_INIT_FN
ECMC_STRUCPP_DECLARE_LOGIC_API_WITH_EXPORTS("machine_logic",
                                            strucpp::Program_MACHINE,
                                            strucpp::locatedVars,
                                            ECMC_STRUCPP_EXPORT_INIT_FN);
#else
ECMC_STRUCPP_DECLARE_LOGIC_API("machine_logic",
                               strucpp::Program_MACHINE,
                               strucpp::locatedVars);
#endif
