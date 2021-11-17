"""Add IdentifierView.

Revision ID: 65099af7d24f
Revises: adb06291d483
Create Date: 2021-10-28 16:01:33.825427

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '65099af7d24f'
down_revision = 'adb06291d483'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('identifier_view',
    sa.Column('house_id', sa.Integer(), nullable=False),
    sa.Column('identifier', sa.String(length=256), nullable=False),
    sa.Column('view_name', sa.String(length=256), nullable=False),
    sa.ForeignKeyConstraint(['house_id'], ['house.house_id'], ),
    sa.PrimaryKeyConstraint('house_id', 'identifier')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('identifier_view')
    # ### end Alembic commands ###