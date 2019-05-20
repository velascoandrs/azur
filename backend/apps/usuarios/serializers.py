from rest_framework_simplejwt.serializers import TokenObtainPairSerializer


class TokenObtainPairPatchedSerializer(TokenObtainPairSerializer):

    def to_representation(self, instance):
        r = super(TokenObtainPairPatchedSerializer, self).to_representation(instance)
        r.update({'user': self.user.email})
        return r



