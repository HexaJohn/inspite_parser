const _ = '''
ABDOMEN
ADAM'S APPLE
ANKLE
ANUS
APPENDIX
ARM
ARMPIT
ARTERY
BACK
BEARD
BELLY
BELLY-BUTTON
BICEPS
BLADDER
BLOOD
BONE
BOSOM
BRAINS
BREAST
BUTT-CHEEK
CALF
CAPILLARY
CELL
CERVIX
CHEEK
CHEST
CHIN
CRANIUM
CUTICLE
EAR
EARDRUM
ELBOW
EPIDERMIS
ESOPHAGUS
EYE
EYEBROW
EYELASH
EYELID
FACE
FINGER
FINGERNAIL
FIST
FOOT
FOREARM
FOREHEAD
FORESKIN
GALL BLADDER
GLAND
GROIN
GUM
HAIR
HAIRDO
HAND
HEAD
HEART
HEEL
HIP
INTESTINE
JAW
KIDNEY
KNEE
KNEECAP
KNUCKLE
LEG
LIGAMENT
LIP
LIVER
LUNG
MANDIBLE
MOUSTACHE
MOUTH
MUSCLE
NECK
NECKLINE
NERVE
NIPPLE
NOSE
NOSTRIL
ORGAN
PALATE
PALM
PANCREAS
PENIS
PROSTATE
PUBIS
RECTUM
RIB
SCALP
SCROTUM
SHIN
SHOULDER
SHOULDER BLADE
SINUS
SKELETON
SKIN
SKIN
SKULL
SOLE
SPINE
SPLEEN
STERNUM
STOMACH
TEMPLE
TENDON
TESTICLE
THIGH
THORAX
THROAT
THUMB
THYROID
TOE
TOENAIL
TONGUE
TONSIL
TOOTH
TRACHEA
UMBILICAL CORD
URETHRA
UTERUS
UVULA
VAGINA
VEIN
VENA
WAIST
WINDPIPE
WRIST
''';

final Set<String> nounsBodyParts = _.split('\n').toSet();
